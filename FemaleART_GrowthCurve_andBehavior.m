
% clear all;
 close all;
% 
% 
%%%%%%
 load('FemaleARTs.mat')

 
 %%%growth curve%%%%
mp=50;%number of male
fp=51;%number of female

 
figure(1)
subplot(2,1,2)  
  
for i=1:mp
 
  X=1:5000; 
  Y=Ag(i).Size;
  plot(X,Y,'g');
  hold on
  Z=Ag(i).OSz;
  idsz=Z(find(Z>0));
  idx=X(find(Z>0));
  plot(idx,idsz,'ko');  
  hold on
end


subplot(2,1,1)

 

for i=fp:100

  X=1:5000; 
  Y=Ag(i).Size;
  plot(X,Y,'m');
  hold on
  Z=Ag(i).OSz;
  idsz=Z(find(Z>0));
  idx=X(find(Z>0));
  plot(idx,idsz,'ko');  
  hold on
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



f1=51;%QoF gene index from data
f2=52;%NoF gene index from data

sg=150; % QoF size

fi=0;
SS=linspace(sg/300,sg/300,1);
 


for sz=1:length(SS)
 figure(13)



%male face and food

x1=0; %sex
x2=1; %bias
x3=1; % mate state
x4=0.5; %set energy;
x5=SS(sz); %own size
x6=0.8;%life
%x7=50/300;%160/300;%nearest male size

%x8=0.1; %0.05:0.01:1;front male
x9=-1; %back male
x10=-1; %front female
x11=-1; %back female
x12=1; % food distance

X=[];
Y=[];
Z=[];


gene=init_robot.Robot_gene(f1,:);

        W1=gene(:,1:4);
        W2=gene(:,5:8);
        W3=gene(:,9:12);
        W4=gene(:,13:16);
        W5=gene(:,17:20);
        W6=gene(:,21:24);
        W7=gene(:,25:28);
        W8=gene(:,29:32);
        W9=gene(:,33:36);
        W10=gene(:,37:40);
        W11=gene(:,41:44);
        W12=gene(:,45:48);
        
for x7=0.01:0.01:0.3

     for x8=0.01:0.01:1
        
        
       X1=[x1' x1' x1' x1'];
       X2=[x2' x2' x2' x2'];
       X3=[x3' x3' x3' x3'];
       X4=[x4' x4' x4' x4'];
       X5=[x5' x5' x5' x5']; 
       X6=[x6' x6' x6' x6']; 
       X7=[x7' x7' x7' x7'];
       X8=[x8' x8' x8' x8']; 
       X9=[x9' x9' x9' x9'];
       X10=[x10' x10' x10' x10'];
       X11=[x11' x11' x11' x11']; 
       X12=[x12' x12' x12' x12']; 
       
       P1=X1.*W1;
       P2=X2.*W2;
       P3=X3.*W3;
       P4=X4.*W4;
       P5=X5.*W5;
       P6=X6.*W6;
       P7=X7.*W7;
       P8=X8.*W8;
       P9=X9.*W9;
       P10=X10.*W10;
       P11=X11.*W11;
       P12=X12.*W12;
       
       M=P1+P2+P3+P4+P5+P6+P7+P8+P9+P10+P11+P12;

       [maxv,ch_module]=max(M);
       
       X=[X x7];
       Y=[Y x8];
       Z=[Z ch_module];
       
       
       

     end
       
       
       
end

c=zeros(length(Z),1)*[0 0 0];
indm=find(Z==1);
indb=find(Z==2);
indp=find(Z==3);
indw=find(Z==4);

c(indm,:)=ones(length(indm),1)*[1 0 0]; %red
c(indb,:)=ones(length(indb),1)*[0 1 0]; %green
c(indp,:)=ones(length(indp),1)*[0 0 1]; %blue; %black
c(indw,:)=ones(length(indw),1)*[0.5 0.5 0.5]; %ash


fi=fi+1;

subplot(2,1,1)


scatter(X,Y,[],c)
title('QoF');
xlabel('Male Size');
ylabel('Male Distance');
% sn=SS(sz)*300;
% tit=strcat('S=',int2str(sn));
% title(tit);
grid on;



end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sg=30;%NoF end size
fi=0;
SS=linspace(sg/300,sg/300,1);
 


for sz=1:length(SS)



x1=0; %sex
x2=1; %bias
x3=1; % mate state
x4=0.5; %set energy;
x5= SS(sz); %own size
x6=0.8;%life
%x7=-1;%114/300;%nearest male size

%x8=-1; %0.05:0.01:1;front male
x9=-1; %back male
x10=-1; %front female
x11=-1; %back female
x12=-1; % food distance

X=[];
Y=[];
Z=[];

gene=init_robot.Robot_gene(f2,:);

        W1=gene(:,1:4);
        W2=gene(:,5:8);
        W3=gene(:,9:12);
        W4=gene(:,13:16);
        W5=gene(:,17:20);
        W6=gene(:,21:24);
        W7=gene(:,25:28);
        W8=gene(:,29:32);
        W9=gene(:,33:36);
        W10=gene(:,37:40);
        W11=gene(:,41:44);
        W12=gene(:,45:48);
        
for x7=0.01:0.01:0.3

     for x8=0.01:0.01:1
        
        
       X1=[x1' x1' x1' x1'];
       X2=[x2' x2' x2' x2'];
       X3=[x3' x3' x3' x3'];
       X4=[x4' x4' x4' x4'];
       X5=[x5' x5' x5' x5']; 
       X6=[x6' x6' x6' x6']; 
       X7=[x7' x7' x7' x7'];
       X8=[x8' x8' x8' x8']; 
       X9=[x9' x9' x9' x9'];
       X10=[x10' x10' x10' x10'];
       X11=[x11' x11' x11' x11']; 
       X12=[x12' x12' x12' x12']; 
       
       P1=X1.*W1;
       P2=X2.*W2;
       P3=X3.*W3;
       P4=X4.*W4;
       P5=X5.*W5;
       P6=X6.*W6;
       P7=X7.*W7;
       P8=X8.*W8;
       P9=X9.*W9;
       P10=X10.*W10;
       P11=X11.*W11;
       P12=X12.*W12;
       
       M=P1+P2+P3+P4+P5+P6+P7+P8+P9+P10+P11+P12;

       [maxv,ch_module]=max(M);
       
       X=[X x7];
       Y=[Y x8];
       Z=[Z ch_module];
       
       
       

     end
       
       
       
end

c=zeros(length(Z),1)*[0 0 0];
indm=find(Z==1);
indb=find(Z==2);
indp=find(Z==3);
indw=find(Z==4);

c(indm,:)=ones(length(indm),1)*[1 0 0]; %red
c(indb,:)=ones(length(indb),1)*[0 1 0]; %green
c(indp,:)=ones(length(indp),1)*[0 0 1]; %blue;
c(indw,:)=ones(length(indw),1)*[0.5 0.5 0.5]; %ash

fi=fi+1;

subplot(2,1,2)
scatter(X,Y,[],c)
title('NoF');
xlabel('Male Size');
ylabel('Male Distance');
% sn=SS(sz)*300;
% tit=strcat('S=',int2str(sn));
% title(tit)
grid on;



end




