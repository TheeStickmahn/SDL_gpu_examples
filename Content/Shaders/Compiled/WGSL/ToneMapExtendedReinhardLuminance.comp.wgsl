@group(0u) @binding(0u) var inImage : texture_2d<f32>;

@group(1u) @binding(0u) var outImage : texture_storage_2d<rgba16float, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) v : vec3<u32>) {
  let v_1 = bitcast<vec2<u32>>(bitcast<vec2<i32>>(v.xy));
  let v_2 = textureLoad(inImage, v_1, i32(0u)).xyz;
  let v_3 = dot(v_2, vec3<f32>(0.21259999275207519531f, 0.71520000696182250977f, 0.07220000028610229492f));
  let v_4 = (v_2 * (((v_3 * (1.0f + (v_3 * 0.00000228183375838853f))) / (1.0f + v_3)) / v_3));
  textureStore(outImage, v_1, vec4<f32>(v_4.x, v_4.y, v_4.z, 1.0f));
}
