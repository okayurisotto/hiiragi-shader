#version 120

#include "/lib/defines.glsl"
#include "/lib/colors.glsl"

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 tint;

void main() {
  lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
  texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
  tint = gl_Color;

  gl_Position = ftransform();
}
