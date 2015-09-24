/*
 * Brett Kercher - bmk627
 */

uniform vec4 LMa; // Light-Material ambient
uniform vec4 LMd; // Light-Material diffuse
uniform vec4 LMs; // Light-Material specular
uniform float shininess;

uniform sampler2D normalMap;
uniform sampler2D decal;
uniform sampler2D heightField;
uniform samplerCube envmap;

uniform mat3 objectToWorld;

varying vec2 normalMapTexCoord;
varying vec3 lightDirection;
varying vec3 eyeDirection;
varying vec3 halfAngle;
varying vec3 c0, c1, c2;

void main()
{
	vec3 rgbVal = texture2D(normalMap, vec2(normalMapTexCoord.x * 6, normalMapTexCoord.y * 2)).rgb;
	vec3 normal = (2 * rgbVal) - 1;
	float d = max(dot(normalize(normal), normalize(lightDirection)), 0);

	gl_FragColor = LMa + (d * LMd);  // XXX fix me
}

