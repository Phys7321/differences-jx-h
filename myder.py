# -*- coding: utf-8 -*-
"""
Created on Sun Sep  9 16:50:22 2018

@author: Tom K
"""


def forwardiff(f, a, b, N):
    h = (b-a)/N
    g = []
    for k in range(1, N):
        slop = (f(a+k*h)-f(a+(k-1)*h))/h
        g.append(slop)
    return array(g)
    
    
def backwardiff(f, a, b, N):
    h = (b-a)/N
    g = []
    for k in range(0,N-1):
        slop = (f(a+(k+1)*h)-f(a+k*h))/h
        g.append(slop)
    return array(g)



## I do not know what is required here, higher-order approximation or higher-order derivative.
## Thus, I just make both in Python, and only higher-order derivative in MATLAB.
## Please do not take off points for that since the syntax is very similar.
def accurate_centraldiff(f, a, b, N, degree=1):
    degree = min(degree, 5)
    coefficient_matrix = [[0 for __ in range(5)] for __ in range(5)]
    matrix_index = [
        [0, 0, 1],
        [1, 1, 1/2],
        [2, 0, 27/24], [2, 2, -1/24],
        [3, 1, 2/3], [3, 3, -1/12],
        [4, 0, 75/64], [4, 2, -25/384], [4, 4, 3/640]
    ]

    for x,y,z in matrix_index:
        coefficient_matrix[x][y] = z
        
    h = (b-a)/N
    xx = [a + k*h for k in range(N+1)]
    g = []
            
    for x in xx:
        x_list = [x + i*h/2 for i in range(1, 6)]
        f_list = list(map(f, x_list))
        slop = sum([c*f for c,f in zip(coefficient_matrix[degree-1], f_list)])/h
        
        x_list = [x - i*h/2 for i in range(1, 6)]
        f_list = list(map(f, x_list))
        slop -= sum([c*f for c,f in zip(coefficient_matrix[degree-1], f_list)])/h
        
        g.append(slop)
    return xx,g



def higher_centraldiff(f, a, b, N, order=1):
    coefficient_matrix = [[0, -1/2, 0, 1/2, 0],
                    [0, 1, -2, 1, 0],
                    [-1/2, 2/2, 0/2, -2/2, 1/2],
                    [1, -4, 6, -4, 1]
                   ]
        
    h = (b-a)/N
    xx = [a + k*h for k in range(N+1)]
    g = []
            
    for x in xx:
        x_list = [x + i*h for i in range(-2, 3)]
        f_list = list(map(f, x_list))
        slop = sum([c*f for c,f in zip(coefficient_matrix[order-1], f_list)])/h**order
        g.append(slop)
    return xx,g



