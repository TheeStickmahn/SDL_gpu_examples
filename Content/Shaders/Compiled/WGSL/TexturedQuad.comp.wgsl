struct S {
  ubo_texcoord_multiplier : f32,
}

@group(2u) @binding(0u) var<uniform> UBO : S;

@group(0u) @binding(0u) var inImage : texture_2d<f32>;

@group(0u) @binding(1u) var inImageSampler : sampler;

@group(1u) @binding(0u) var outImage : texture_storage_2d<rgba8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) v : vec3<u32>) {
  let v_1 = textureDimensions(inImage, 0i);
  let v_2 = bitcast<vec2<i32>>(v.xy);
  let v_3 = ((vec2<f32>(v_2) * UBO.ubo_texcoord_multiplier) / vec2<f32>(f32(v_1.x), f32(v_1.y)));
  let v_4 = textureSampleLevel(inImage, inImageSampler, v_3, 0.0f);
  let v_5 = bitcast<vec2<u32>>(v_2);
  textureStore(outImage, v_5, v_4);
}
