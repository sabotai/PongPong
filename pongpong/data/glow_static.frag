//http://glslsandbox.com/e#36431.0
precision highp float;

uniform float u_time;
uniform vec3 u_mouse;
uniform vec3 u_ball;
uniform vec2 u_resolution;
uniform float u_bright; // 0.3 default
uniform float u_size; //0.5 default
uniform vec3 u_color; //0.7, 0.3, 0.3 default
uniform vec3 u_minColor;
uniform vec2 u_contrast; //0.5, 4.0 default

float ball(vec2 p, float siize) {
    vec2 r = vec2(p.x, p.y);    
    return (siize) / length(r); //divisor determines the size of the central bright area
}

float map(float value, float low1, float high1, float low2, float high2){
    float new = low2 + (value - low1) * (high2 - low2) / (high1 - low1);
    return new;
}
float constrain(float value, float mini, float maxi){
    float new = min(value, mini);
    new = max(value, maxi);
    return new;
}

void main(void) {
    vec2 q = gl_FragCoord.xy /  u_resolution.xy;
    vec2 newMouse = u_mouse.xy;// - vec2(u_resolution.x * 0.00013); //can offset by - or +
    q -= newMouse.xy;
    vec2 p = -1.0 + 2.0 * q;    
    //p.x   *= u_mouse.x / u_mouse.y;
    //p.y *= u_mouse.x / u_mouse.y;

    float col = u_bright; // starting value determines min brightness
    //col += ball(p, u_mouse.z); //determines the overall swaying

    q =  gl_FragCoord.xy /  u_resolution.xy;
    q -= u_ball.xy;
    p = -1.0 + 2.0 * q;
    col += ball(p, u_ball.z * u_size); //determines the overall swaying

    col = max(mod(col, u_contrast.x), min(col, u_contrast.y)); // second number is how bright

    vec3 finalColor = vec3(col * u_color.x, col * u_color.y, col * u_color.z);

    //create gradient
    finalColor.x = map(finalColor.x, 0.0, 1.0, u_minColor.x, u_color.x);
    finalColor.y = map(finalColor.y, 0.0, 1.0, u_minColor.y, u_color.y);
    finalColor.z = map(finalColor.z, 0.0, 1.0, u_minColor.z, u_color.z);

    // finalColor.x = constrain(finalColor.x, u_minColor.x * col, u_color.x);
    // finalColor.y = constrain(finalColor.y, u_minColor.y * col, u_color.y);
    // finalColor.z = constrain(finalColor.z, u_minColor.z * col, u_color.z);
    
    gl_FragColor = vec4(finalColor.x, finalColor.y, finalColor.z, 1.0);
}