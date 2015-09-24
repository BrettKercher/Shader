/*
 * Brett Kercher - bmk627
 */

attribute vec2 parametric;

uniform vec3 lightPosition;  // Object-space
uniform vec3 eyePosition;    // Object-space
uniform vec2 torusInfo;		//Major radius in [0] r in [1]

varying vec2 normalMapTexCoord;

varying vec3 lightDirection;
varying vec3 halfAngle;
varying vec3 eyeDirection;
varying vec3 c0, c1, c2;

void main()
{
	float s = parametric.x;
	float t = parametric.y;
	normalMapTexCoord = vec2(s, t);  // OOO fix me
	
	float R = torusInfo.x;
	float r = torusInfo.y;
	
	float U = t * 2 * 3.14159265;
	float V = s * 2 * 3.14159265;
	
	float x = (R + r * cos(U)) * cos(V);
	float y = (R + r * cos(U)) * sin(V);
	float z = r * sin(U);
	
	vec3 vertPosition = vec3(x, y, z);
	
	gl_Position = gl_ModelViewProjectionMatrix * vec4(x, y, z, 1);  // OOO fix me
	
	float gxu = -1 * r * sin(U) * cos(V);
	float gyu = -1 * r * sin(U) * sin(V);
	float gzu = r * cos(U);
	
	float gxv = sin(V) * (-1 * (r * cos(U) + R));
	float gyv = cos(V) * (r * cos(U) + R);
	float gzv = 0;

	vec3 tangent = normalize(vec3(gxv, gyv, gzv));
	vec3 other = normalize(vec3(gxu, gyu, gzu));
	
	vec3 normal = cross(tangent, other);
	vec3 binormal = cross(normal, tangent);
	
	mat3 M = mat3(tangent, binormal, normal);
	
	eyeDirection = transpose(M) * (eyePosition - vertPosition);  // OOO fix me
	lightDirection = transpose(M) * (lightPosition - vertPosition);  // OOO fix me
	halfAngle = (eyeDirection + lightDirection) / 2;  // OOO fix me
	c0 = vec3(0);  // XXX fix me
	c1 = vec3(0);  // XXX fix me
	c2 = vec3(0);  // XXX fix me
}

