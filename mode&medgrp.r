#mode
Mode=function(x){
  h=0
  m=0
  for(i in unique(x)){
    s=0
    for(j in x){
      if(i==j){
        s=s+1
      }
    }
    if(s>h){
      h=s
      m=i
    }
  }
  return(m)
}
a=c(1,2,2,3,1,2,3,4,5,6,4,5,6,1,1)
Mode(a)

