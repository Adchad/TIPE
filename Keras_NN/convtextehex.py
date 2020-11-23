def ecrire_message(message,a_offset):
    L = []
    for i in range(len(message)):
        if(message[i]==" "):
            L.append("0x26")
        else:
            L.append(hex(ord(message[i])-65 + int(a_offset)))
            
    
    for i in range(360-len(message)):
        L.append('0x26')
    
    
        
    f = open("message.c" ,"w")
    f.write("unsigned char message[] ={ ")
    for i in range(len(L)-1):
        f.write(L[i] + " , ")
    f.write(L[-1] + " };")
    
    
        
    return L , len(L)
    
    

    