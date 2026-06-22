#include "Common.h"

static int Init(Context* context)
{
	return CommonInit(context, SDL_WINDOW_RESIZABLE);
}

static float r = 1.0f, g = 0.0f, b = 0.0f;
static int phase = 0;

constexpr float speed = 0.0035f;

static int Update(Context* context)
{
	switch (phase) {
		case 0:
			g += speed;
			if (g >= 1.0f)
				phase = 1;
		break; // red -> yellow
		case 1:
			r -= speed;
			if (r <= 0.0f)
				phase = 2;
		break; // yellow -> green
		case 2:
			b += speed;
			if (b >= 1.0f)
				phase = 3;
		break; // green -> cyan
		case 3:
			g -= speed;
			if (g <= 0.0f)
				phase = 4;
		break; // cyan -> blue
		case 4:
			r += speed;
			if (r >= 1.0f)
				phase = 5;
		break; // blue -> magenta
		case 5:
			b -= speed;
			if (b <= 0.0f)
				phase = 0;
		break; // magenta -> red
	}
	return 0;
}

static int Draw(Context* context)
{
    SDL_GPUCommandBuffer* cmdbuf = SDL_AcquireGPUCommandBuffer(context->Device);
    if (cmdbuf == NULL)
    {
        SDL_Log("AcquireGPUCommandBuffer failed: %s", SDL_GetError());
        return -1;
    }

    SDL_GPUTexture* swapchainTexture;
    if (!SDL_WaitAndAcquireGPUSwapchainTexture(cmdbuf, context->Window, &swapchainTexture, NULL, NULL)) {
        SDL_Log("WaitAndAcquireGPUSwapchainTexture failed: %s", SDL_GetError());
        return -1;
    }

	if (swapchainTexture != NULL)
	{
		SDL_GPUColorTargetInfo colorTargetInfo = { 0 };
		colorTargetInfo.texture = swapchainTexture;
		colorTargetInfo.clear_color = (SDL_FColor){ r, g, b, 1.0f };
		colorTargetInfo.load_op = SDL_GPU_LOADOP_CLEAR;
		colorTargetInfo.store_op = SDL_GPU_STOREOP_STORE;

		SDL_GPURenderPass* renderPass = SDL_BeginGPURenderPass(cmdbuf, &colorTargetInfo, 1, NULL);
		SDL_EndGPURenderPass(renderPass);
	}

	SDL_SubmitGPUCommandBuffer(cmdbuf);

	return 0;
}

static void Quit(Context* context)
{
	CommonQuit(context);
}

Example ClearScreen_Example = { "ClearScreen", Init, Update, Draw, Quit };
