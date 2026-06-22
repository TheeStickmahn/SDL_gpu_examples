cmake_minimum_required(VERSION 3.10)
project(SDL_gpu_examples)

set(CMAKE_C_STANDARD 23)

set(SDL_WGPU_LIB "dawn")
set(SDL_WGPU_STATIC ON)
set(SDL_WGPU_LIB_BYO ON)

add_subdirectory(extern/SDL)
add_executable(SDL_gpu_examples
    Examples/main.c
    Examples/Common.h
    stb_image.h
    Examples/Common.c
    Examples/ClearScreen.c
    Examples/ClearScreenMultiWindow.c
    Examples/BasicTriangle.c
    Examples/BasicVertexBuffer.c
    Examples/CullMode.c
    Examples/BasicStencil.c
    Examples/InstancedIndexed.c
    Examples/TexturedQuad.c
    Examples/ComputeSampler.c
    Examples/TexturedAnimatedQuad.c
    Examples/Clear3DSlice.c
    Examples/BasicCompute.c
    Examples/ComputeUniforms.c
    Examples/ToneMapping.c
    Examples/CustomSampling.c
    Examples/DrawIndirect.c
    Examples/ComputeSpriteBatch.c
    Examples/CopyAndReadback.c
    Examples/CopyConsistency.c
    Examples/Texture2DArray.c
    Examples/TriangleMSAA.c
    Examples/Cubemap.c
    Examples/WindowResize.c
    Examples/Blit2DArray.c
    Examples/BlitCube.c
    Examples/BlitMirror.c
    Examples/GenerateMipmaps.c
    Examples/Latency.c
    Examples/DepthArray.c
    Examples/DepthSampler.c
    Examples/PullSpriteBatch.c
    Examples/TextureTypeTest.c
    Examples/CompressedTextures.c
    Examples/Bloom.c
)

add_custom_command(TARGET SDL_gpu_examples PRE_LINK
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Content $<TARGET_FILE_DIR:SDL_gpu_examples>/Content
)

target_compile_options(SDL_gpu_examples PRIVATE "--use-port=emdawnwebgpu")
set_target_properties(SDL_gpu_examples PROPERTIES SUFFIX ".html")
target_link_libraries(SDL_gpu_examples PRIVATE SDL3::SDL3)
target_link_options(SDL_gpu_examples PRIVATE
    "-sASYNCIFY=1"
    "-sALLOW_MEMORY_GROWTH=1"
    "--use-port=emdawnwebgpu"
    "--preload-file" "Content/"
)
