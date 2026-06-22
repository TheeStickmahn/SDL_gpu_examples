@group(2u) @binding(0u) var ColorTexture : texture_2d<f32>;

@group(2u) @binding(1u) var ColorSampler : sampler;

@group(2u) @binding(2u) var DepthTexture : texture_2d<f32>;

@group(2u) @binding(3u) var DepthSampler : sampler;

var<private> v : vec4<f32>;

fn main_inner(v_1 : vec2<f32>) {
  let v_2 = textureSample(ColorTexture, ColorSampler, v_1);
  let v_3 = textureSample(DepthTexture, DepthSampler, v_1).x;
  let v_4 = textureDimensions(DepthTexture, 0i);
  let v_5 = f32(v_4.x);
  let v_6 = f32(v_4.y);
  let v_7 = step(0.20000000298023223877f, max((textureSample(DepthTexture, DepthSampler, (v_1 + (vec2<f32>((1.0f / v_5), 0.0f) * 1.0f))).x - v_3), max((textureSample(DepthTexture, DepthSampler, (v_1 + (vec2<f32>((-1.0f / v_5), 0.0f) * 1.0f))).x - v_3), max((textureSample(DepthTexture, DepthSampler, (v_1 + (vec2<f32>(0.0f, (1.0f / v_6)) * 1.0f))).x - v_3), (textureSample(DepthTexture, DepthSampler, (v_1 + (vec2<f32>(0.0f, (-1.0f / v_6)) * 1.0f))).x - v_3)))));
  let v_8 = textureDimensions(DepthTexture, 0i);
  let v_9 = f32(v_8.x);
  let v_10 = f32(v_8.y);
  let v_11 = step(0.20000000298023223877f, max((textureSample(DepthTexture, DepthSampler, (v_1 + (vec2<f32>((1.0f / v_9), 0.0f) * 2.0f))).x - v_3), max((textureSample(DepthTexture, DepthSampler, (v_1 + (vec2<f32>((-1.0f / v_9), 0.0f) * 2.0f))).x - v_3), max((textureSample(DepthTexture, DepthSampler, (v_1 + (vec2<f32>(0.0f, (1.0f / v_10)) * 2.0f))).x - v_3), (textureSample(DepthTexture, DepthSampler, (v_1 + (vec2<f32>(0.0f, (-1.0f / v_10)) * 2.0f))).x - v_3)))));
  let v_12 = mix(mix(v_2.xyz, vec3<f32>(), vec3<f32>(v_11, v_11, v_11)), vec3<f32>(1.0f), vec3<f32>(v_7, v_7, v_7));
  v = vec4<f32>(v_12.x, v_12.y, v_12.z, v_2.w);
}

@fragment
fn main(@location(0u) v_13 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_13);
  return v;
}
