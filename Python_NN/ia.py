from sympy.interactive.printing import init_printing
init_printing(use_unicode=False, wrap_line=False, no_global=True)
from sympy.matrices import Matrix, eye, zeros, ones
import numpy as np
from math import exp

def min(L):
    m=L[0]
    for i in L:
        if i<m:
            m=i
    return m
    

def InptoM(A):
    P=[]
    a=len(A)
    b=len(A[0])
    for i in range(a):
        for j in range(b):
            P.append(A[i][j])
    return Matrix(P)

            
def sigmoid(U):
    K=[]
    for i in range(U.shape[0]):
        K.append([1/(1+ exp(-U[i]))])
    return Matrix(K)


def weight(n1,n2):
    W=zeros(n1,n2)
    return W

def bias(ni):
    B=zeros(ni,1)
    return B

I=InptoM(np.zeros((24,24,1)))

W1=weight(16,576)
B1=bias(16)
W2=weight(2,16)
B2=bias(2)

 
 
def neuron(I,W1,B1,W2,B2):
    R=[[0],[1]]
    P=[]
    L=sigmoid(W1*I+B1)
    M=sigmoid(W2*L+B2)
    return N
    
 

def cost(I,W1,W2,B1,B2,V): 
    N=neuron(I,W1,B1,W2,B2)
    a=0
    for j in range(N.shape[0]):
            a=((N[j]-V[j])**2)+a
    return a
    

def matelem(n1,n2,i,j,pas):
    p=zeros(n1,n2)
    p[i,j]=pas
    
def derive(I):
    
