uniform float time;

uniform float minX;
uniform float minY;
uniform float minZ;

uniform float maxX;
uniform float maxY;
uniform float maxZ;

uniform float radius;
uniform float starRotationSpeed;

uniform vec3 starColor;
uniform vec3 starEdgeColor;
uniform vec3 starEmission;

uniform vec3 meshPosition;

varying vec3 worldPosition;


/// Ray Related
struct Ray {
    vec3 position;
    vec4 color;
    vec3 direction;
};

void calculateColorShift(){

}

void calculateGravityShift(){

}

void rayStep(){

}

/// General Physics Related

const float speedOfLight = 173.0; // au per day
const float newtonsConstant = 3.3604e63; // au3 sun-1 day-2

/// Titania Related

const float titania_mass = 70.0;  //sun
//const float titania_innerTorus;
//const float titania_outerTorus;
//const vec3 titania_position;


float sdfTitania(Titania object, Ray probe){ //returns distance to "minimum" lensing
    //float schwarzschildRadius =
    return 0.0;
}

float sdfEventHorizon(Titania object, Ray probe){ //returns distance to event horizon
    return 0.0;
}

/// Accretion Disk & Emission Disk Related
struct AccretionDisk{
    float radiusOuter;
    float radiusInner;
    vec3 position;
};

float sdfAccretionDisk(AccretionDisk object, Ray probe){
    return 0.0;
}

struct EmissionCone{
    float distanceToCenter;
    float angle;
};

float sdfEmissionCone(EmissionCone object, Ray probe){
    return 0.0;
}

/// Scene Related

void sdfSpaceDistanceProbe(){
    //function must query all constituents
}

void rayMarch(vec3 position, vec3 direction){
    //TODO: create 4 rays and interpolate results ?
    //perhaps ray splitting can occur based on the degree of tilting? We would need r for this.    

}













float rand(vec2 co){
    return sin(co.x);
}

#define STEP_SIZE 0.01

vec4 densityProbe(vec3 in_position){
    if(distance(in_position , meshPosition) <= radius){
        return vec4(starEdgeColor, 0.08);
    }else{
        return vec4(0.0,0.0,0.0,0.0);
    }

}

float sphereDistance (vec3 p, vec3 center, float r)
{
    return distance(p,center) - r;
}

#define BACKGROUND_RADIUS 100.0 // hmmm

vec4 getBackground(vec3 out_position, vec3 direction){
    
    for (int i = 0; i < 2000; i++) // change this to smart book lookup
    {
        float distanceToSphere = sphereDistance(out_position, vec3(0.0,0.0,0.0), BACKGROUND_RADIUS);
        direction = direction;

        if(distanceToSphere < 0.0){
            out_position += distanceToSphere * direction;
        }else{
            return vec4(rand(out_position.xy),rand(out_position.yz),rand(out_position.xz) , 1.0); //todo clamp might be needed
        }
    }
    return vec4(0.0,0.0,0.0,1.0);
}

vec4 volumetricRayCast (vec3 in_position, vec3 direction)
{
    vec4 sample = vec4(0 , 0 , 0 , 0.0);
    vec3 position = in_position;

    for (int i = 0; i < 2000; i++) // change this to smart book lookup
    {
        if(position.x > maxX || position.x < minX ){
            return sample += getBackground(in_position, direction);
        }
        if(position.y > maxY || position.y < minY ){
            return sample += getBackground(in_position, direction);
        }
        if(position.z > maxZ || position.z < minZ ){
            return sample += getBackground(in_position, direction);
        }
        if(sample[3] > 1.0){
            break;
        }
        vec4 local = vec4(0.0,0.0,0.0,0.0);//densityProbe(position);
        //vec4 local = localDensitySample(vec3(vec4(in_position,0.0) * rotm));
        
        float distance = sphereDistance(position, meshPosition, radius);

        if(distance > STEP_SIZE){
            vec3 gravityVector = vec3(0.0,0.0,0.0) - position;
            float rayDistance = length(gravityVector);

            // 0.05: rate of smaller steps when approaching blackhole
            float stepSize = min(STEP_SIZE, rayDistance - 0.3 * 0.05);

            direction += gravityVector * 0.1 / (rayDistance * rayDistance * rayDistance);
            position += distance * direction;
            local = vec4(0.0,0.0,0.0,0.05);
            sample += local;

        }else{
            position += direction * STEP_SIZE;
        }
    }

    return sample;
}


void main()
{

    gl_FragColor = volumetricRayCast( worldPosition, normalize(worldPosition - cameraPosition)); 
}