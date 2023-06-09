// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle2> particles;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle2>();
  }

  void addParticle(float x, float y) {
    particles.add(new Particle2(x,y));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle2 p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
