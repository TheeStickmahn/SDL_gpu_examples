@group(1u) @binding(0u) var OutImage : texture_storage_2d<rgba8unorm, write>;

struct S {
  ubo_time : f32,
}

@group(2u) @binding(0u) var<uniform> UBO : S;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) v : vec3<u32>) {
  let v_1 = textureDimensions(OutImage);
  let v_2 = vec2<f32>(v.xy);
  let v_3 = UBO.ubo_time;
  let v_4 = (vec3<f32>(0.5f) + (cos(((vec3<f32>(v_3, v_3, v_3) + ((v_2 / vec2<f32>(f32(v_1.x), f32(v_1.y)))).xyx) + vec3<f32>(0.0f, 2.0f, 4.0f))) * 0.5f));
  let v_5 = bitcast<vec2<u32>>(vec2<i32>(v_2));
  textureStore(OutImage, v_5, vec4<f32>(v_4.x, v_4.y, v_4.z, 1.0f));
}
