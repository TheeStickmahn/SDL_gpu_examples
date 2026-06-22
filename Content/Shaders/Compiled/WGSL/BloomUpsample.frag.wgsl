@group(2u) @binding(0u) var ColorTexture : texture_2d<f32>;

@group(2u) @binding(1u) var ColorSampler : sampler;

struct S {
  FilterRadius : f32,
}

@group(3u) @binding(0u) var<uniform> UBO : S;

var<private> v : vec4<f32>;

fn main_inner(v_1 : vec2<f32>) {
  let v_2 = UBO.FilterRadius;
  let v_3 = v_1.x;
  let v_4 = (v_3 - v_2);
  let v_5 = v_1.y;
  let v_6 = (v_5 + v_2);
  let v_7 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_4, v_6)).xyz;
  let v_8 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_3, v_6)).xyz;
  let v_9 = (v_3 + v_2);
  let v_10 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_9, v_6)).xyz;
  let v_11 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_4, v_5)).xyz;
  let v_12 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_3, v_5)).xyz;
  let v_13 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_9, v_5)).xyz;
  let v_14 = (v_5 - v_2);
  let v_15 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_4, v_14)).xyz;
  let v_16 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_3, v_14)).xyz;
  let v_17 = ((((v_12 * 4.0f) + ((((v_8 + v_11) + v_13) + v_16) * 2.0f)) + (((v_7 + v_10) + v_15) + textureSample(ColorTexture, ColorSampler, vec2<f32>(v_9, v_14)).xyz)) * 0.0625f);
  v = vec4<f32>(v_17.x, v_17.y, v_17.z, 1.0f);
}

@fragment
fn main(@location(0u) v_18 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_18);
  return v;
}
