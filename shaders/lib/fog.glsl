vec4 fog(vec4 color, float vertexDistance, float fogStart, float fogEnd, vec4 fogColor) {
  if (vertexDistance <= fogStart) {
    return color;
  }
  if (fogEnd < vertexDistance) {
    return fogColor;
  }

  float fogAmount = smoothstep(fogStart, fogEnd, vertexDistance);
  return vec4(mix(color, fogColor, fogAmount));
}
