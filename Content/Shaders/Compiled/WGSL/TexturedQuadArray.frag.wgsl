@group(2u) @binding(0u) var Texture : texture_2d_array<f32>;

@group(2u) @binding(1u) var Sampler : sampler;

var<private> v : vec4<f32>;

fn main_inner(v_1 : vec2<f32>) {
  let v_2 = bitcast<u32>(select(0i, 1i, (v_1.y > 0.5f)));
  let v_3 = vec3<f32>(v_1.x, v_1.y, f32(v_2));
  v = textureSample(Texture, Sampler, v_3.xy, i32(v_3.z));
}

@fragment
fn main(@location(0u) v_4 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_4);
  return v;
}
