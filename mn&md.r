#Function to find mean and median of a sequence

Mean= function(x)
{
  n=length(x)
  s=0
  for(i in 1:n)
  {
    s =s+x[i]
  }
  return(s/n)
}
a=c(10,20,30)
Mean(a)

Median =function(x)
{
  n= length(x)
  x=sort(x)
  if(n%%2==1)
  {
    a=(n+1)/2
    s1=x[a]
  }
  else{
    a1=(n/2)
    a2=(n/2)+1
    s1=x[a1]+x[a2])/2
  }
  return (s1)}
b=c(10,20,30,40)
Median(b)
