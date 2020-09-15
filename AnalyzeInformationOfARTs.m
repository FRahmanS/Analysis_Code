%%% Analyze male and female phenotype evolved along with additional
%%% information such as total battery captured, total mating, lifetime
%%% invested in each module etc.

 tic
clear all
close all
%path(pathdef)

cd '../Final7/MC5'
% path(path,'../data folder')

%load('9Test80MAX.mat') testing
MP=50;% Number of males
NP=100;% number of total agent in population
F= [20 50 80 100 150 200]; % Here F is food density tested. change it to reproductive cost or male ratio as needed

k=length(F);
Result={'Index','NumMalePh','MaleGrowth','NumFemalePh','FemaleGrowth','M/F ratio','M/F','MaleEndSize,Growth','FemaleEndSize,Growth','totBM','NoMCB','totBF','NoFCB','totmateM/numofMaleMating','numofMaleMating','totmateF/numofFemaleMating','numofFemaleMating','Var(MMating)','VarFMating',...
          'Mean(MaleL)','Var(MaleL)','Mean(FemaleL)','Var(FemaleL)','Mean(MaleM)','Var(MaleM)','Mean(MaleM/L)','Var(MaleM/L)','Mean(MaleB)','Var(MaleB)','Mean(MaleB/L)','Var(MaleB/L)','Mean(MaleP)','Var(MaleP)','Mean(MaleP/L)','Var(MaleP/L)',...
          'Mean(MaleW)','Var(MaleW)','Mean(MaleW/L)','Var(MaleW/L)','Mean(FemaleM)','Var(FemaleM)','Mean(FemaleM/L)','Var(FemaleM/L)','Mean(FemaleB)','Var(FemaleB)','Mean(FemaleB/L)','Var(FemaleB/L)','Mean(FemaleP)','Var(FemaleP)','Mean(FemaleP/L)','Var(FemaleP/L)',...
          'Mean(FemaleW)','Var(FemaleW)','Mean(FemaleW/L)','Var(FemaleW/L)','MatingCost'};
 
MAX={'Index','NMP','MP1(GR,Smax,Smin,AvgB,TB,NMCB,AvgM,TM,NMM,AM,AB,AP,AW)','MP2(GR,Smax,Smin,AvgB,TB,NMCB,AvgM,TM,NMM,AM,AB,AP,AW)','MP3(GR,Smax,Smin,AvgB,TB,NMCB,AvgM,TM,NMM,AM,AB,AP,AW)','MP4(GR,Smax,Smin,AvgB,TB,NMCB,AvgM,TM,NMM,AM,AB,AP,AW)'};      

FAY={'Index','NFP','FP1(GR,Smax,Smin,AvgB,TB,NFCB,AvgM,TM,NFM,AM,AB,AP,AW)','FP2(GR,Smax,Smin,AvgB,TB,NFCB,AvgM,TM,NFM,AM,AB,AP,AW)','FP3(GR,Smax,Smin,AvgB,TB,NFCB,AvgM,TM,NFM,AM,AB,AP,AW)','FP4(GR,Smax,Smin,AvgB,TB,NFCB,AvgM,TM,NFM,AM,AB,AP,AW)'};

for indX=1:k % k=number of conditions for food density, reproductive cost or male ratio to be tested.
    
for jndX=1:rep %  rep is the repitition of the test. Please edit it here. for the paper it is 25  
    
    
num=int2str(jndX); % data file is saved as "Test_number Test food/reproductivecost/maleratio". example : 1Test20.
                    % here these code is only to load all data files one b                    % one
fk=F(indX);
Food=int2str(fk);

% name='9Test80MAX';
%name=strcat(num,'Test',Food);
NM=strcat(num,'NMCTest',Food,'.mat');
FNM=dir(NM);
if isempty(FNM)
 continue;    
end

load(FNM.name);
NP=100;
MP=50;
Result1=cell(1,56); %clear
% MAX1=cell(1,6);
% FAY1=cell(1,6);
Result1{1,1}=FNM.name;
Result1{1,56}=fk;

%TGnew=table(TG.analyzeGen12==300,1:12);
M=TG{TG.analyzeGen12==300,1:12}; %clear

NumMaleph=unique(M(1:MP,10));
Result1{1,2}=size(NumMaleph,1);  
Result1{1,3}=NumMaleph;

NumFemaleph=unique(M(MP+1:NP,10));
Result1{1,4}=size(NumFemaleph,1);  
Result1{1,5}=NumFemaleph;

 EndSize=zeros(1,100);
  for ss=1:100
    
  SSize=max(Ag3(100,ss).Size);    
  EndSize(ss)= SSize;
  
  end   
M=[M EndSize'];
TGNew=array2table(M);

lem=find(M(1:MP,4)>4000);
[MaleEndSizeB,IB]=max(EndSize(lem));
MSIB=M(lem(IB),10);
[MaleEndSizeS,IS]=min(EndSize(lem));
MSIS=M(lem(IS),10);

MV=var(EndSize(lem));
MM=mean(EndSize(lem));

MaleEndSize=[MaleEndSizeB MSIB;MaleEndSizeS MSIS;MM MV];
Result1{1,8}=MaleEndSize; 
  
  
lef=find(M(MP+1:NP,4)>4000)+MP;
[FemaleEndSizeB,IBf]=max(EndSize(lef));
FSIB=M(lef(IBf),10);
[FemaleEndSizeS,ISf]=min(EndSize(lef));
FSIS=M(lef(ISf),10);

FM=mean(EndSize(lef));
FV=var(EndSize(lef));

FemaleEndSize=[FemaleEndSizeB FSIB;FemaleEndSizeS FSIS;FM FV];
Result1{1,9}=FemaleEndSize;   
  
%M/F Size  
MBF=MaleEndSizeB/FemaleEndSizeB;
  if (MBF==1)
     r='SS';
  elseif (MBF>1)
     r='MB';     
  elseif (MBF<1)
     r='FB';     

  end
  
Result1{1,6}=MBF;
Result1{1,7}=r;   

SumMBC=sum(M(1:MP,3));
MBC=find(M(1:MP,3)>0);
NMBC=size(MBC,1);  
Result1{1,10}=SumMBC;  
Result1{1,11}=NMBC;

SumFBC=sum(M(MP+1:NP,3));
FBC=find(M(MP+1:NP,3)>0);
NFBC=size(FBC,1);  
Result1{1,12}=SumFBC;  
Result1{1,13}=NFBC;


SumMMC=sum(M(1:MP,2));
MMC=find(M(1:MP,2)>0);
NMMC=size(MMC,1);  
Result1{1,14}=SumMMC/NMMC;  
Result1{1,15}=NMMC;

SumFMC=sum(M(MP+1:NP,2));
FMC=find(M(MP+1:NP,2)>0);
NFMC=size(FMC,1);  
Result1{1,16}=SumFMC/NFMC;  
Result1{1,17}=NFMC;

Result1{1,18}=var(M(1:MP,2));
Result1{1,19}=var(M(MP+1:NP,2));

Result1{1,20}=mean(M(1:MP,4));
Result1{1,21}=var(M(1:MP,4));

Result1{1,22}=mean(M(MP+1:NP,4));
Result1{1,23}=var(M(MP+1:NP,4));

Result1{1,24}=mean(M(1:MP,5));
Result1{1,25}=var(M(1:MP,5));
Result1{1,28}=mean(M(1:MP,6));
Result1{1,29}=var(M(1:MP,6));
Result1{1,32}=mean(M(1:MP,7));
Result1{1,33}=var(M(1:MP,7));
Result1{1,36}=mean(M(1:MP,8));
Result1{1,37}=var(M(1:MP,8));

Result1{1,40}=mean(M(MP+1:NP,5));
Result1{1,41}=var(M(MP+1:NP,5));
Result1{1,44}=mean(M(MP+1:NP,6));
Result1{1,45}=var(M(MP+1:NP,6));
Result1{1,48}=mean(M(MP+1:NP,7));
Result1{1,49}=var(M(MP+1:NP,7));
Result1{1,52}=mean(M(MP+1:NP,8));
Result1{1,53}=var(M(MP+1:NP,8));


M(:,5)= M(:,5)./ M(:,4);
M(:,6)= M(:,6)./ M(:,4);
M(:,7)= M(:,7)./ M(:,4);
M(:,8)= M(:,8)./ M(:,4);


Result1{1,26}=mean(M(1:MP,5));
Result1{1,27}=var(M(1:MP,5));
Result1{1,30}=mean(M(1:MP,6));
Result1{1,31}=var(M(1:MP,6));
Result1{1,34}=mean(M(1:MP,7));
Result1{1,35}=var(M(1:MP,7));
Result1{1,38}=mean(M(1:MP,8));
Result1{1,39}=var(M(1:MP,8));

Result1{1,42}=mean(M(MP+1:NP,5));
Result1{1,43}=var(M(MP+1:NP,5));
Result1{1,46}=mean(M(MP+1:NP,6));
Result1{1,47}=var(M(MP+1:NP,6));
Result1{1,50}=mean(M(MP+1:NP,7));
Result1{1,51}=var(M(MP+1:NP,7));
Result1{1,54}=mean(M(MP+1:NP,8));
Result1{1,55}=var(M(MP+1:NP,8));

Result=[Result;Result1];

 NumM=Result1{1,2};
if(NumM>1 && NumM<5)
 MAX1=cell(1,6);   
 MAX1{1,1}=FNM.name;
 MAX1{1,2}=Result1{1,2};
 
 %NumM=Result1{1,2};
 MPh=Result1{1,3};
 MPh=sort(MPh);
 
 for nmp=1:NumM
   Phenotype=TGNew{TGNew.M10==MPh(nmp)&TGNew.M1<=MP,:};  
   Smax=max(Phenotype(:,13));
   Smin=min(Phenotype(:,13));
   gr=MPh(nmp);
   tb=sum(Phenotype(:,3));
   ntb=size(find(Phenotype(:,3)>0),1);
   avgb=tb/ntb;
   tm=sum(Phenotype(:,2));
   ntm=size(find(Phenotype(:,2)>0),1);
   avgm=tm/ntm;
   meanM=sum(Phenotype(:,5))/size(Phenotype,1);
   meanB=sum(Phenotype(:,6))/size(Phenotype,1);
   meanP=sum(Phenotype(:,7))/size(Phenotype,1);
   meanW=sum(Phenotype(:,8))/size(Phenotype,1);
   
   max1=[gr Smax Smin avgb tb ntb avgm tm ntm meanM meanB meanP meanW ];
   MAX1{1,2+nmp}=max1;
   
 end
 
 MAX=[MAX;MAX1];
    
end


 NumF=Result1{1,4};
if(NumF>1 && NumF<5)
 FAY1=cell(1,6);   
 FAY1{1,1}=FNM.name;
 FAY1{1,2}=Result1{1,4};
 
%  NumF=Result1{1,2};
 FPh=Result1{1,5};
 FPh=sort(FPh);
 
 for nmp=1:NumF
   Phenotype=TGNew{TGNew.M10==FPh(nmp)&TGNew.M1>MP,:};  
   Smax=max(Phenotype(:,13));
   Smin=min(Phenotype(:,13));
   gr=FPh(nmp);
   tb=sum(Phenotype(:,3));
   ntb=size(find(Phenotype(:,3)>0),1);
   avgb=tb/ntb;
   tm=sum(Phenotype(:,2));
   ntm=size(find(Phenotype(:,2)>0),1);
   avgm=tm/ntm;
   meanM=sum(Phenotype(:,5))/size(Phenotype,1);
   meanB=sum(Phenotype(:,6))/size(Phenotype,1);
   meanP=sum(Phenotype(:,7))/size(Phenotype,1);
   meanW=sum(Phenotype(:,8))/size(Phenotype,1);
   
   fay=[gr Smax Smin avgb tb ntb avgm tm ntm meanM meanB meanP meanW ];
   FAY1{1,2+nmp}=fay;
   
 end
 
 FAY=[FAY;FAY1];
    
end



end 
 
end


save ('MC1_F100'); %result is saved as .mat file

 
 
 
 
