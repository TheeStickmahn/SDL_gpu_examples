#include "Common.h"
#include <SDL3/SDL_main.h>
#include <dirent.h>
#include <emscripten/emscripten.h>
#include <stdlib.h>
static Example *Examples[] = {&ClearScreen_Example,
#if !(defined(SDL_PLATFORM_XBOXONE) || defined(SDL_PLATFORM_XBOXSERIES) ||     \
      defined(__EMSCRIPTEN__))
                              &ClearScreenMultiWindow_Example,
#endif
                              &BasicTriangle_Example,
                              &BasicVertexBuffer_Example,
                              &CullMode_Example,
                              &BasicStencil_Example,
                              &InstancedIndexed_Example,
                              &TexturedQuad_Example,
                              &TexturedAnimatedQuad_Example,
                              &Clear3DSlice_Example,
                              &BasicCompute_Example,
                              &ComputeUniforms_Example,
                              &ToneMapping_Example,
                              &CustomSampling_Example,
                              &DrawIndirect_Example,
                              &ComputeSampler_Example,
                              &CopyAndReadback_Example,
                              &CopyConsistency_Example,
                              &Texture2DArray_Example,
                              &TriangleMSAA_Example,
                              &Cubemap_Example,
                              &WindowResize_Example,
                              &Blit2DArray_Example,
                              &BlitCube_Example,
                              &BlitMirror_Example,
                              &GenerateMipmaps_Example,
                              &Latency_Example,
                              &DepthSampler_Example,
                              &DepthArray_Example,
                              &ComputeSpriteBatch_Example,
                              &PullSpriteBatch_Example,
                              &TextureTypeTest_Example,
                              &CompressedTextures_Example,
                              &Bloom_Example};

bool AppLifecycleWatcher(void *userdata, SDL_Event *event) {
  /* This callback may be on a different thread, so let's
   * push these events as USER events so they appear
   * in the main thread's event loop.
   *
   * That allows us to cancel drawing before/after we finish
   * drawing a frame, rather than mid-draw (which can crash!).
   */
  if (event->type == SDL_EVENT_DID_ENTER_BACKGROUND) {
    SDL_Event evt;
    evt.type = SDL_EVENT_USER;
    evt.user.code = 0;
    SDL_PushEvent(&evt);
  } else if (event->type == SDL_EVENT_WILL_ENTER_FOREGROUND) {
    SDL_Event evt;
    evt.type = SDL_EVENT_USER;
    evt.user.code = 1;
    SDL_PushEvent(&evt);
  }
  return false;
}
static Context context = {0};
static int exampleIndex = -1;
static int gotoExampleIndex = 0;
static int quit = 0;
static float lastTime = 0;
SDL_Gamepad *gamepad = NULL;
bool canDraw = true;

static void update(void) {
  context.LeftPressed = 0;
  context.RightPressed = 0;
  context.DownPressed = 0;
  context.UpPressed = 0;

  SDL_Event evt;
  while (SDL_PollEvent(&evt)) {
    if (evt.type == SDL_EVENT_QUIT) {
      if (exampleIndex != -1) {
        Examples[exampleIndex]->Quit(&context);
      }
      quit = 1;
    } else if (evt.type == SDL_EVENT_GAMEPAD_ADDED) {
      if (gamepad == NULL) {
        gamepad = SDL_OpenGamepad(evt.gdevice.which);
      }
    } else if (evt.type == SDL_EVENT_GAMEPAD_REMOVED) {
      if (evt.gdevice.which == SDL_GetGamepadID(gamepad)) {
        SDL_CloseGamepad(gamepad);
      }
    } else if (evt.type == SDL_EVENT_KEY_DOWN) {
      if (evt.key.key == SDLK_D) {
        gotoExampleIndex = exampleIndex + 1;
        if (gotoExampleIndex >= SDL_arraysize(Examples)) {
          gotoExampleIndex = 0;
        }
      } else if (evt.key.key == SDLK_A) {
        gotoExampleIndex = exampleIndex - 1;
        if (gotoExampleIndex < 0) {
          gotoExampleIndex = SDL_arraysize(Examples) - 1;
        }
      } else if (evt.key.key == SDLK_LEFT) {
        context.LeftPressed = true;
      } else if (evt.key.key == SDLK_RIGHT) {
        context.RightPressed = true;
      } else if (evt.key.key == SDLK_DOWN) {
        context.DownPressed = true;
      } else if (evt.key.key == SDLK_UP) {
        context.UpPressed = true;
      }
    } else if (evt.type == SDL_EVENT_GAMEPAD_BUTTON_DOWN) {
      if (evt.gbutton.button == SDL_GAMEPAD_BUTTON_RIGHT_SHOULDER) {
        gotoExampleIndex = exampleIndex + 1;
        if (gotoExampleIndex >= SDL_arraysize(Examples)) {
          gotoExampleIndex = 0;
        }
      } else if (evt.gbutton.button == SDL_GAMEPAD_BUTTON_LEFT_SHOULDER) {
        gotoExampleIndex = exampleIndex - 1;
        if (gotoExampleIndex < 0) {
          gotoExampleIndex = SDL_arraysize(Examples) - 1;
        }
      } else if (evt.gbutton.button == SDL_GAMEPAD_BUTTON_DPAD_LEFT) {
        context.LeftPressed = true;
      } else if (evt.gbutton.button == SDL_GAMEPAD_BUTTON_DPAD_RIGHT) {
        context.RightPressed = true;
      } else if (evt.gbutton.button == SDL_GAMEPAD_BUTTON_DPAD_DOWN) {
        context.DownPressed = true;
      } else if (evt.gbutton.button == SDL_GAMEPAD_BUTTON_DPAD_UP) {
        context.UpPressed = true;
      }
    }
  }
  if (quit) {
    exit(-69);
  }

  if (gotoExampleIndex != -1) {
    if (exampleIndex != -1) {
      Examples[exampleIndex]->Quit(&context);
      SDL_zero(context);
    }

    exampleIndex = gotoExampleIndex;
    context.ExampleName = Examples[exampleIndex]->Name;
    SDL_Log("STARTING EXAMPLE: %s", context.ExampleName);
    if (Examples[exampleIndex]->Init(&context) < 0) {
      SDL_Log("Init failed!");
    }

    gotoExampleIndex = -1;
  }

  float newTime = SDL_GetTicks() / 1000.0f;
  context.DeltaTime = newTime - lastTime;
  lastTime = newTime;

  if (Examples[exampleIndex]->Update(&context) < 0) {
    SDL_Log("Update failed!");
  }

  if (canDraw) {
    if (Examples[exampleIndex]->Draw(&context) < 0) {
      SDL_Log("Draw failed!");
    }
  }
}

int main(int argc, char **argv) {
  SDL_SetLogPriorities(SDL_LOG_PRIORITY_DEBUG);

  for (int i = 1; i < argc; i += 1) {
    if (SDL_strcmp(argv[i], "-name") == 0 && argc > i + 1) {
      const char *exampleName = argv[i + 1];
      int foundExample = 0;

      for (int j = 0; j < SDL_arraysize(Examples); j += 1) {
        if (SDL_strcmp(Examples[j]->Name, exampleName) == 0) {
          gotoExampleIndex = j;
          foundExample = 1;
          break;
        }
      }

      if (!foundExample) {
        SDL_Log("No example named '%s' exists.", exampleName);
        return 1;
      }
    }
  }

  if (!SDL_Init(SDL_INIT_VIDEO | SDL_INIT_GAMEPAD)) {
    SDL_Log("Failed to initialize SDL: %s", SDL_GetError());
    return 1;
  }

  InitializeAssetLoader();
  // SDL_AddEventWatch(AppLifecycleWatcher, NULL);

  SDL_Log("Welcome to the SDL_GPU example suite!");
  SDL_Log("Press A/D (or LB/RB) to move between examples!");

  DIR *dir;
  struct dirent *ent;
  if ((dir = opendir("/Content/Shaders/Compiled/WGSL/")) != NULL) {
    /* print all the files and directories within directory */
    while ((ent = readdir(dir)) != NULL) {
      SDL_LogInfo(SDL_LOG_CATEGORY_GPU, "Found file: %s\n", ent->d_name);
    }
    closedir(dir);
  } else {
    /* could not open directory */
    SDL_LogError(SDL_LOG_CATEGORY_GPU, "Could not open directory!");
    return EXIT_FAILURE;
  }

  emscripten_set_main_loop(update, false, true);
  return 0;
}
