function result= removeBlank(M,box)
box= floor(box);
box(box<1) = 1; 
D= M(box(2):box(2)+box(5),box(1):box(1)+box(4),box(3):box(3)+box(6));
[l,w,h]=size(D);
result=uint8(zeros(l+4,w+4,h+4));
result(3:l+2,3:w+2,3:h+2)=D;
end