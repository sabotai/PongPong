//http://glslsandbox.com/e#36431.0
precision highp float;

uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_resolution;
uniform float u_bright; // 0.3 default
uniform float u_size; //0.5 default
uniform vec3 u_color; //0.7, 0.3, 0.3 default

float ball(vec2 p, float fx, float fy, float ax, float ay) {
    vec2 r = vec2(p.x, p.y);    
    return u_size / length(r); //divisor determines the size of the central bright area
}

void main(void) {
    vec2 q = gl_FragCoord.xy /  u_resolution.xy;
    vec2 newMouse = u_mouse.xy;// - vec2(u_resolution.x * 0.00013); //can offset by - or +
    q -= newMouse.xy;
    vec2 p = -1.0 + 2.0 * q;    
    //p.x   *= u_mouse.x / u_mouse.y;
    //p.y *= u_mouse.x / u_mouse.y;

    float col = u_bright; // starting value determines overall brightness
    //col += ball(p, 10000000000000.0, 0.00001, 0.1, 0.2);
    col += ball(p, 0.0, 0.16, 0.0, 0.09); //determines the overall swaying
    col = max(mod(col, 0.5), min(col, 4.0)); // second number is how bright
    
    gl_FragColor = vec4(col * u_color.x, col * u_color.y, col * u_color.z, 1.0);
}