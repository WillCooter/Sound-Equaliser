function [b, a]  = shelving(G, fc, fs, Q)

K = tan((pi * fc)/fs);
V0 = 10^(G/20);
m = 1/Q;

%Invert gain if a cut

if(V0 < 1)
    V0 = 1/V0;
end

if( G > 0 )
   
    b0 = (1 + sqrt(V0)*m*K + V0*K^2) / (1 + m*K + K^2);
    b1 =             (2 * (V0*K^2 - 1) ) / (1 + m*K + K^2);
    b2 = (1 - sqrt(V0)*m*K + V0*K^2) / (1 + m*K + K^2);
    a1 =                (2 * (K^2 - 1) ) / (1 + m*K + K^2);
    a2 =             (1 - m*K + K^2) / (1 + m*K + K^2);

elseif ( G < 0)
    
    b0 =             (1 + m*K + K^2) / (1 + m*sqrt(V0)*K + V0*K^2);
    b1 =                (2 * (K^2 - 1) ) / (1 + m*sqrt(V0)*K + V0*K^2);
    b2 =             (1 - m*K + K^2) / (1 + m*sqrt(V0)*K + V0*K^2);
    a1 =             (2 * (V0*K^2 - 1) ) / (1 + m*sqrt(V0)*K + V0*K^2);
    a2 = (1 - m*sqrt(V0)*K + V0*K^2) / (1 + m*sqrt(V0)*K + V0*K^2);

else
    b0 = V0;
    b1 = 0;
    b2 = 0;
    a1 = 0;
    a2 = 0;
end

a = [  1, a1, a2];
b = [ b0, b1, b2];
