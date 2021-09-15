#version 120

#include "/lib/defines.glsl"
#include "/lib/colors.glsl"

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

  gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(worldPos + offset - cameraPosition, 1.0);
}
