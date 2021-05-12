%inverse function 


function [ify,y,info]=invgraph(f,a,b,N)
  eps = 1e-4;


  xs = a + eps;
  xe= b + eps;
  ys = f(xs);
  ye = f(xe);
  
  if (ys == ye)
    info = -1;
    return 
  end 
  
  if (ye < ys)
    aa = ys; ys=ye;ye=aa;
    aa=xs; xs=xe;xe=aa;
   end
  y = linspace(ys,ye,N+1);
  x = zeros(size(y));
  x(1) = xs;
  for k=2:N+1,
    #sprawdzenie czy funkcja ma stały znak
    x(k) = fsolve(@(x) y(k)- f(x), x(k-1));
   end
   
   if (abs(x(1) - x(end)) < 1e-3) #nie mozna odwrócić
      info = -2;
      return 
   end 
   
   ify = x;
   info = 0;
  
   
 endfunction

f_error = @(x) x.^2 
a = 2 
b = 2
[ify,y, info] = invgraph(f_error, a, b, 100)
 
 
f_error = @(x) x.^2 
a = -2 
b = 2
[ify,y, info] = invgraph(f_error, a, b, 100)
 
 
f1 = @(x) x.^2 
a = 1
b = 2
[ify,y, info] = invgraph(f1, a, b, 100)
plot(y, ify)
 
f2 = @(x) 1-x.^2 
a = 1
b = 2 
[ify,y, info] = invgraph(f2, a, b, 100)
plot(y, ify)

f3 = @(x) sin(x) 
a = -1.5
b = 1.5
[ify,y, info] = invgraph(f3, a, b, 100)
plot(y, ify)

f4 = @(x) 2*x+sin(x) 
a = -1
b = 2 
[ify,y, info] = invgraph(f4, a, b, 100)
plot(y, ify)