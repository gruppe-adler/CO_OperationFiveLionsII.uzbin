grad_stones = "#particlesource" createVehicleLocal (getpos player); 
grad_stones setParticleCircle [0, [0, 0, 0]];
grad_stones setParticleRandom [0, [random 10 - random 20,  random 10 - random 20, 10], [0.25, 0.25, 0], 0, 1.5, [0, 0, 0, 0], 0, 0];
grad_stones setParticleParams [["\Ca\Data\ParticleEffects\Pstone\Pstone.p3d", 8, 3, 1], "", "SpaceObject", 1, 10, [0, 0, 0], [0, 0, -2], 1, 10, 1, 0.2, [0.02, 0.02], [[1, 1, 1 ,1], [1, 1, 1, 1], [1, 1, 1, 1]], [0, 1], 1, 0, "", "", vehicle player];
grad_stones setDropInterval 0.04;

// grad_stones enableSimulation false;

grad_stones