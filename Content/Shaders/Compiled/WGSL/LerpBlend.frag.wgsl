@group(2u) @binding(0u) var PrimaryTexture : texture_2d<f32>;

@group(2u) @binding(1u) var PrimarySampler : sampler;

@group(2u) @binding(2u) var SecondaryTexture : texture_2d<f32>;

@group(2u) @binding(3u) var SecondarySampler : sampler;

struct S {
  Weight : f32,
}

@group(3u) @binding(0u) var<uniform> UBO : S;

var<private> v : vec4<f32>;

fn main_inner(v_1 : vec2<f32>) {
  let v_2 = textureSample(PrimaryTexture, PrimarySampler, v_1);
  let v_3 = textureSample(SecondaryTexture, SecondarySampler, v_1);
  let v_4 = UBO.Weight;
  v = mix(v_2, v_3, vec4<f32>(v_4, v_4, v_4, v_4));
}

@fragment
fn main(@location(0u) v_5 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_5);
  return v;
}
