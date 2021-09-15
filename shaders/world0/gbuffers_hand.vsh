#version 120

#include "/lib/defines.glsl"
#include "/lib/colors.glsl"

uniform float frameTimeCounter;
uniform int heldItemId;
uniform int heldItemId2;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 tint;

void main() {
  lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
  texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
  tint = gl_Color;

  vec3 vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
  vec3 vPosPlayer = mat3(gbufferModelViewInverse) * vPosView;
  vec3 worldPos = vPosPlayer + cameraPosition;
  vec3 offset = vec3(0.0);

  int id = heldItemId - 10000;
  int id2 = heldItemId2 - 10000;

  if (id == 1 || id2 == 1) {
  } else {
    offset.x += sin(frameTimeCounter * 8 / 5) / 64;
    offset.y += sin(frameTimeCounter * 5 / 5) / 64;
  }

  gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(worldPos + offset - cameraPosition, 1.0);
}
