@group(2u) @binding(0u) var DepthTexture : texture_2d_array<f32>;

@group(2u) @binding(1u) var DepthSampler : sampler;

var<private> v : vec4<f32>;

fn main_inner(v_1 : vec2<f32>) {
  let v_2 = bitcast<u32>(select(0i, 1i, (v_1.y > 0.5f)));
  let v_3 = vec3<f32>(v_1.x, v_1.y, f32(v_2));
  let v_4 = textureSample(DepthTexture, DepthSampler, v_3.xy, i32(v_3.z)).x;
  v = vec4<f32>(v_4, v_4, v_4, 1.0f);
}

@fragment
fn main(@location(0u) v_5 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_5);
  return v;
}
