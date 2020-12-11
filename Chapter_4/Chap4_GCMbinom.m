%Chapter 4 Code for GCM Binom call

clc;clear;close all;
%Parameter set up
N = 2*80;
N_A = round(N*.968);

c = 4; %scaling parameter
w = [0.19,0.12,0.25,0.45]; %weight for each stimulus

%Load in and group the face stimulation data
facestim = csvread('faceStim.csv');
facestimMat(1,:,:) = facestim(1:5,:); %Category 1
facestimMat(2,:,:) = facestim(6:10,:); %Category 2


%Function for GCM
preds = Chap4_GCMpred(facestim(1,:),facestimMat,c,w);

%Likelihood calculation
likelihood = binopdf(N_A,N,preds(1));
