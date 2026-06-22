@group(2u) @binding(0u) var ColorTexture : texture_2d<f32>;

@group(2u) @binding(1u) var ColorSampler : sampler;

var<private> v : vec4<f32>;

fn main_inner(v_1 : vec2<f32>) {
  let v_2 = textureDimensions(ColorTexture, 0i);
  let v_3 = (vec2<f32>(1.0f) / vec2<f32>(f32(v_2.x), f32(v_2.y)));
  let v_4 = v_3.x;
  let v_5 = v_3.y;
  let v_6 = v_1.x;
  let v_7 = (2.0f * v_4);
  let v_8 = (v_6 - v_7);
  let v_9 = v_1.y;
  let v_10 = (2.0f * v_5);
  let v_11 = (v_9 + v_10);
  let v_12 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_8, v_11)).xyz;
  let v_13 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_6, v_11)).xyz;
  let v_14 = (v_6 + v_7);
  let v_15 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_14, v_11)).xyz;
  let v_16 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_8, v_9)).xyz;
  let v_17 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_6, v_9)).xyz;
  let v_18 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_14, v_9)).xyz;
  let v_19 = (v_9 - v_10);
  let v_20 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_8, v_19)).xyz;
  let v_21 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_6, v_19)).xyz;
  let v_22 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_14, v_19)).xyz;
  let v_23 = (v_6 - v_4);
  let v_24 = (v_9 + v_5);
  let v_25 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_23, v_24)).xyz;
  let v_26 = (v_6 + v_4);
  let v_27 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_26, v_24)).xyz;
  let v_28 = (v_9 - v_5);
  let v_29 = textureSample(ColorTexture, ColorSampler, vec2<f32>(v_23, v_28)).xyz;
  let v_30 = ((((v_17 * 0.125f) + ((((v_12 + v_15) + v_20) + v_22) * 0.03125f)) + ((((v_13 + v_16) + v_18) + v_21) * 0.0625f)) + ((((v_25 + v_27) + v_29) + textureSample(ColorTexture, ColorSampler, vec2<f32>(v_26, v_28)).xyz) * 0.125f));
  v = vec4<f32>(v_30.x, v_30.y, v_30.z, 0.0f);
}

@fragment
fn main(@location(0u) v_31 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_31);
  return v;
}
