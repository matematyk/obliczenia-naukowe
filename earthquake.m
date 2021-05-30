

%earthquake model of n storey bld
n=10;
m=k=ones(n,1);
%our data m(i)=1e4*kg k(i)=5000*kg/s^2
m=m*10000;
k=5000*k;
m(1) = 30000;
k(1) = 10000;


function [Fr,A]=freqofbld(m,k)
%we compute frequencies of the buiding
%INPUT
%m,k - vectors of masses of storeys and coeff of restoration forces
%OUTPUT
%Fr- frequancies of the bld (sqrt(-eigenvalues of M^{-1}S))
n=length(m);
iM=diag(1.0./m); %inverse of M
k=[k;0]; %k(n+1)=0 as air - last storey  restoration force is zero... 
S=diag(-k(1:n)-k(2:n+1))+diag(k(2:n),-1)+diag(k(2:n),1);
A=iM*S;
Fr=sqrt(-eig(A)); 
endfunction

%test it 
[Fr,A]=freqofbld(m,k);
P=2*pi/Fr
if (P > 2 && P < 3) 
  disp("we have error");
  return
endif 
x0=dx0=zeros(n,1);
#We assume that x(0)=x'(0)=0
G=5000
gdm=G/m(1);
gamma=3;
T=15;
t=linspace(0,T,300);
f=@(x,t) [x(n+1:2*n);A*x(1:n)]+[gdm*cos(gamma*1);zeros(2*n-1,1)];
X=lsode(f,[x0;dx0],t);
# Plot the graphs (in one graphical window (figure)) of the displacements of 1st and the last floors (x1(t) and x10(t)) on $[0,T] for T=15. 
plot(t,X(:,1),";shifts for 1st floor;");pause(2);
plot(t,X(:,(2*n-1)),";shifts for last floor;");pause(2);

# and plot the graph of F(t)= max_k|x(k)(t)|.

Ft=max(abs(transpose(X(:,[1:2:2*n]))));
plot(t,Ft)
