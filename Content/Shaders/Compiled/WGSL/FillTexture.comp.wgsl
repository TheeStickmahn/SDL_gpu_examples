@group(1u) @binding(0u) var outImage : texture_storage_2d<rgba8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) v : vec3<u32>) {
  let v_1 = bitcast<vec2<u32>>(bitcast<vec2<i32>>(v.xy));
  textureStore(outImage, v_1, vec4<f32>(f32(v.x) % 1, f32(v.y) % 1, 0.0f, 1.0f));
}
