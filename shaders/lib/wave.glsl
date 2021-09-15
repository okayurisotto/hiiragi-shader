float wave(float frameTimeCounter, vec3 worldPos, float speed, float strength) {
  vec3 pos = sin(worldPos);
  return (
      sin(frameTimeCounter * speed * 2.0 + (pos.x + pos.y + pos.z)) / 16.0 * strength
    + sin(frameTimeCounter * speed * 5.0 + (pos.x + pos.y + pos.z)) / 16.0 * strength
  ) / 2;
}
