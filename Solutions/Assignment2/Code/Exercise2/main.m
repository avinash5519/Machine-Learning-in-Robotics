N=12 ;
A=importdata('A.txt');
B=importdata('B.txt');
pi=importdata('pi.txt');

%N is total number of states
%T is total observations in a sequence =60
%B is 8*12 Observation matrix(Probability of having ith observation in jth state)
%A is 12*12 transition matrix (Probability of having ith state to jth state)
%pi is 1*12 priors

input_seqns1=importdata('A_Train_Binned.txt');
[T,total_sequences]=size(input_seqns1);

%Calculate log-likelihood of A_Train_Binned
likelihoodsArray1=zeros(total_sequences,1);




classesArray1=zeros(total_sequences,1);
for sequence_no =1:total_sequences
    observation_sequence=input_seqns1(:,sequence_no);
    likelihood=calculateLikelihood(A,B,pi,T,N,observation_sequence);
    likelihoodsArray1(sequence_no)=likelihood ;
    if(likelihood > -120)
        classesArray1(sequence_no,1)=1 ;
     end
end 
likelihoodsArray1
%All 1 if classified as train
classesArray1


%Calculate log-likelihood of A_Train_Binned
likelihoodsArray2=zeros(total_sequences,1);
input_seqns2=importdata('A_Test_Binned.txt');

[T,total_sequences]=size(input_seqns2);


classesArray2=zeros(total_sequences,1);

for sequence_no =1:total_sequences
    observation_sequence=input_seqns2(:,sequence_no);
    likelihood=calculateLikelihood(A,B,pi,T,N,observation_sequence);
    likelihoodsArray2(sequence_no)=likelihood ;
    if(likelihood < -120)
        classesArray2(sequence_no,1)=1 ;
     end
end 

likelihoodsArray2
%All 1 if classified as test
classesArray2




 

    