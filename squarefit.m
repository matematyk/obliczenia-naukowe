addpath(pwd)

function psq=squarefit(x,y)
  [k, u]= size(x);
  A = [x', (x.^2)', ones(u,1)];
  [Q,R,P] = qr(A);
  [m,n] = size(A);
  c = Q'*y';
  % numeryczny rząd:
  r = 1;
  eps_new = max(size(A))*eps*abs(R(1,1));
   for i = 2:n
      if (abs(R(i,i)) >= eps_new)
        r = r + 1
      endif
    endfor

  if(r<n) 
   disp("Macierz z rzędem mniejszym niż n");
   disp("rank(A) <= n");
  end
 
  % rozwiaż LLSP dla y2
  S = [ R(1:r,1:r) \ R(1:r,r+1:n); eye(n-r) ]
  t = [ R(1:r,1:r) \ c(1:r); zeros(n-r,1) ];
  y2 = S \ t; % rozwiązanie problemu LLSP
  % Obliczam psq
  y1 = R(1:r,1:r) \ ( c(1:r) - R(1:r,r+1:n) * y2 );
  psq = P*[y1;y2];
end



%%% tests:
%%% first test
x1 = [1 2 3]
x2 = [1.5 2.2 3.3]
x3 = [10 100 1000]
y = @(x) 3*x.^2-x+ 10;

squarefit(x1,y(x1))
squarefit(x2,y(x2))
squarefit(x3,y(x3))
%%% second test
y1 =  @(x) 3*x.*x-1 + 0.1*randn(size(x));
N = 10
x = linspace(0, 1, N)
b = y1(x)
squarefit(x,b)

%-take such x and y of length 100 such that the matrix is not of maximal column rank 
%(it is part of a homework how to find such data...) and test your function - it should issue a warning on a display!
%%% third test
x = repmat([2, 4], 1, 50)
squarefit(x, y1(x))

