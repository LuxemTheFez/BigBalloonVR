shader_type spatial;

void fragment(){
	ALBEDO = vec3(0.0,0.0,0.0);
	float x = 2.0*UV.x-1.0;
	float y = 2.0*UV.y-1.0;
	float dista = sqrt(x*x + y*y) ;
	float one = 1.0;
	float time = modf(TIME * 0.1,one);
	float dist = dista - time + 1.0;
	dist = modf(dist,one);
	if(
		(
			//(dista<0.05) || 
			(dist>0.15 && dist<0.2) || 
			(dist>0.35 && dist<0.4) || 
			(dist>0.55 && dist<0.6) || 
			(dist>0.75 && dist<0.8) || 
			(dist>0.95)
			//|| (dista>0.95)
		) && dist < 1.0
		){
		ALPHA = clamp(1.0-dista*dista,0.3,1.0);
	}
	else{
		ALPHA = 0.0;
	}
	if(dista>0.99 && dista<1.0){
		ALBEDO = vec3(1.0,1.0,1.0);
		ALPHA = 1.0;
	}
	if(dista>=1.0){
		ALPHA = 0.0;
	}
	
}