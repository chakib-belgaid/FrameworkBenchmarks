import time  as tt

class measure : 
    PKG0_file='/sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/energy_uj'
    # PKG1_file='/sys/devices/virtual/powercap/intel-rapl/intel-rapl:1/energy_uj'

    def __init__(self):
        # self.pkg0=open(measure.PKG0_file,'r')
        # self.pkg1=open(measure.PKG1_file,'r')
        energy.setup()
    def get_energy(self): 
        with open(measure.PKG0_file,'r') as self.pkg0:
            pkg0 =int(self.pkg0.readline())
        # with open(measure.PKG1_file,'r') as self.pkg1:
        #     pkg1 =int(self.pkg1.readline())
        time = tt.time()
        return energy(pkg0,time)

class energy : 
    MAX_ENERGY_uj_file='/sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/max_energy_range_uj'

    @staticmethod
    def setup(): 
        with open (energy.MAX_ENERGY_uj_file ,'r') as f : 
            energy.MAX_ENERGY_uj= int(f.readline())
            
    def __init__(self,pkg0,time): 
        self.pkg0 = pkg0
        # self.pkg1 = pkg1
        self.time = time 

    def __add__(self,x): 
        if x == 0 : 
            return self 
        return energy(self.pkg0+x.pkg0,self.time + x.time)

    def __sub__(self,x): 
        if x == 0 : 
            return self 
        pkg0 = self.pkg0 - x.pkg0
        # pkg1 = self.pkg1 - x.pkg1 
        time = self.time - x.time
        
        if pkg0 < 0 : pkg0 = pkg0+energy.MAX_ENERGY_uj
        # if pkg1 < 0 : pkg1 = pkg1+energy.MAX_ENERGY_uj
        return energy(pkg0,time)

    def __float__(self): 
        return float(self.pkg0+self.pkg1)/10**6

    def __str__(self):
        return '{:.2f}s, {:.2f} J'.format(self.time,float(self.pkg0)/10**6)       