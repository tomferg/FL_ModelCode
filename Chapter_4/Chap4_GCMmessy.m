clc;clear;close all;

N = 2*40;
bestfit = 10000;

%Load in and group the face stimulation data
facestim = csvread('faceStim.csv');
facestimMat(1,:,:) = facestim(1:5,:); %Category 1
facestimMat(2,:,:) = facestim(6:10,:); %Category 2

%Read data and multiply by N - why?
data = readmatrix('facesDataLearners.txt');
data = data*N;

%Note: the book here looped over different combinations of values
%This seemed to be due to the optimization funciton and for visualization
%As I used fmincon I decided to stick with the middle value (0.5)
%I would advise playing around with a variety of starting values though
w1 = [0.25,0.5,0.75];
w2 = [0.25,0.5,0.75];
w3 = [0.25,0.5,0.75];

%This sets up the function to be ran
bestfit = 10000;
for W1counter = 1:length(w1)
    for W2counter = 1:length(w2)
        for W3counter = 1:length(w3)
            
            startParameters = [1,w1(W1counter),w2(W1counter),w3(W1counter),1,0.2];
            lower = [0,0,0,0,0,-5];
            upper = [10,1,1,1,10,5];
            fun = @(startParameters)Chap4_GCMmulti(startParameters,facestim,facestimMat,data,N,0);
            
            %This runs the optimization function
            [x, FVAL,~,output] = fmincon(fun,startParameters,[],[],[],[],lower,upper);
            
            
            for paramCounter = 1:length(x)
                if FVAL < bestfit
                    bestres = x;
                    bestfit = FVAL;
                end
            end
        end
    end
end

preds = Chap4_GCMmulti(bestres,facestim,facestimMat,data,N,1);


scatter(data./N,preds)
disp(bestres); %this is the max likelihood values
w=[];
w(1) = bestres(2);
w(2) = (1-w(1))*bestres(3);
w(3) = (1-sum(w))*bestres(4);
w(4) = 1 - sum(w);
disp(w);

