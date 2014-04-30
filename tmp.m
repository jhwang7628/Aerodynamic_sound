% IMPLEMENTATION OF THE CALCULATION OF AERODYNAMIC SOUND USING SOUND TEXTURE
% Following: Real-time Rendering of Aerodynamic Sound using Sound Textures based on Computational Fluid Dynamics

function [T,Pv,X,U,ObjSpeed,O,TexTable_g] = main_v2(ReceiPos,SampFreq,PrevData)

global TexTable_g gl_g O

O=ReceiPos;

% INITIALIZE THE VARIABLES
tend = 3;
T = linspace(0,tend,SampFreq.*tend).';
NumElem = 5; % Number of discretization of the object
v0 = 10;
dt = T(2) - T(1);
c0 = 340;
gl_g = zeros(length(T),NumElem,3); 


if nargin < 3
   [PRaw] = TextureConstruc;
else 
   TexTable_g = PrevData;
   % PRaw = sprintf('N/A');
end
   
[X,U,ObjSpeed] = ObjMotion(T,NumElem,'rotate');  % ObjMotion(T,NumElem,flag)

   
S_k = T(1);
for kk = 1:length(T)
      [ObjPosition, ObjSpeed] = ObjMotion2(T(kk),NumElem,'standing_wind_random')
   for ll = 1:NumElem
      
      [S_k,gl_g(kk,ll,:)] = CompGFunc(ObjSpeed(kk,ll),v0,dt,S_k);
      % S_k_mon(kk) = S_k;
   end
end
   
Pv = CompPReceiver(X,c0,T);
   

% POSTPROCESSING, SOUND RENDERING


end
