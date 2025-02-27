Devia =function(x)
{
  n= length(x)
  x=sort(x)
  s=0
  m=Mean(x)
for(i in 1:n)
{
  s =s+(x[i]-m)^2
}
st=sqrt(s/n)
return (st)}
b=c(10,20,30,40)
Devia(b)

