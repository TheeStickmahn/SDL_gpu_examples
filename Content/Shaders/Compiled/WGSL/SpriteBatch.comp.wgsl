struct SpriteComputeData {
  Position : vec3<f32>,
  Rotation : f32,
  Scale : vec2<f32>,
  Padding : vec2<f32>,
  TexU : f32,
  TexV : f32,
  TexW : f32,
  TexH : f32,
  Color : vec4<f32>,
}

struct S {
  tint_symbol : array<SpriteComputeData>,
}

@group(0u) @binding(0u) var<storage, read> ComputeBuffer : S;

struct SpriteVertex {
  Position : vec4<f32>,
  Texcoord : vec2<f32>,
  Color : vec4<f32>,
}

struct S_1 {
  tint_symbol_1 : array<SpriteVertex>,
}

@group(1u) @binding(0u) var<storage, read_write> VertexBuffer : S_1;

@compute @workgroup_size(64u, 1u, 1u)
fn main(@builtin(global_invocation_id) v : vec3<u32>) {
  let v_1 = v.x;
  let v_2 = ComputeBuffer.tint_symbol[v_1].Position;
  let v_3 = ComputeBuffer.tint_symbol[v_1].Rotation;
  let v_4 = ComputeBuffer.tint_symbol[v_1].Scale;
  let v_5 = ComputeBuffer.tint_symbol[v_1].TexU;
  let v_6 = ComputeBuffer.tint_symbol[v_1].TexV;
  let v_7 = ComputeBuffer.tint_symbol[v_1].TexW;
  let v_8 = ComputeBuffer.tint_symbol[v_1].TexH;
  let v_9 = ComputeBuffer.tint_symbol[v_1].Color;
  let v_10 = cos(v_3);
  let v_11 = sin(v_3);
  let v_12 = ((mat4x4<f32>(vec4<f32>(1.0f, 0.0f, 0.0f, 0.0f), vec4<f32>(0.0f, 1.0f, 0.0f, 0.0f), vec4<f32>(0.0f, 0.0f, 1.0f, 0.0f), vec4<f32>(v_2.x, v_2.y, v_2.z, 1.0f)) * mat4x4<f32>(vec4<f32>(v_10, v_11, 0.0f, 0.0f), vec4<f32>(-(v_11), v_10, 0.0f, 0.0f), vec4<f32>(0.0f, 0.0f, 1.0f, 0.0f), vec4<f32>(0.0f, 0.0f, 0.0f, 1.0f))) * mat4x4<f32>(vec4<f32>(v_4.x, 0.0f, 0.0f, 0.0f), vec4<f32>(0.0f, v_4.y, 0.0f, 0.0f), vec4<f32>(0.0f, 0.0f, 1.0f, 0.0f), vec4<f32>(0.0f, 0.0f, 0.0f, 1.0f)));
  let v_13 = (v_1 * 4u);
  VertexBuffer.tint_symbol_1[v_13].Position = (v_12 * vec4<f32>(0.0f, 0.0f, 0.0f, 1.0f));
  let v_14 = (v_13 + 1u);
  VertexBuffer.tint_symbol_1[v_14].Position = (v_12 * vec4<f32>(1.0f, 0.0f, 0.0f, 1.0f));
  let v_15 = (v_13 + 2u);
  VertexBuffer.tint_symbol_1[v_15].Position = (v_12 * vec4<f32>(0.0f, 1.0f, 0.0f, 1.0f));
  let v_16 = (v_13 + 3u);
  VertexBuffer.tint_symbol_1[v_16].Position = (v_12 * vec4<f32>(1.0f, 1.0f, 0.0f, 1.0f));
  VertexBuffer.tint_symbol_1[v_13].Texcoord = vec2<f32>(v_5, v_6);
  let v_17 = (v_5 + v_7);
  VertexBuffer.tint_symbol_1[v_14].Texcoord = vec2<f32>(v_17, v_6);
  let v_18 = (v_6 + v_8);
  VertexBuffer.tint_symbol_1[v_15].Texcoord = vec2<f32>(v_5, v_18);
  VertexBuffer.tint_symbol_1[v_16].Texcoord = vec2<f32>(v_17, v_18);
  VertexBuffer.tint_symbol_1[v_13].Color = v_9;
  VertexBuffer.tint_symbol_1[v_14].Color = v_9;
  VertexBuffer.tint_symbol_1[v_15].Color = v_9;
  VertexBuffer.tint_symbol_1[v_16].Color = v_9;
}
