import java.util.*;
public class crc {
void div(int a[],int k)            
{
int gp[]={1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1};
for(int i=0;i<k;i++)
{
int count=0;
if(a[i]==1)
{
for(int j=i;j<17+i;j++)      {j=1; j<18; j++}
{
a[j]=a[j]^gp[count++];       { a[1]=a[1]^gp[0]}
}
}
}
}

public static void main(String args[])
{
int a[]=new int[100];
int b[]=new int[100];
int len, k;
crc ob=new crc();
System.out.println("Enter the length of Data Frame:");
Scanner sc=new Scanner(System.in);
len=sc.nextInt();
int flag=0;
System.out.println("Enter the Message:");
for(int i=0;i<len;i++)
{
a[i]=sc.nextInt();
}
for(int i=0;i<16;i++)
{ 	
a[len++]=0; 
} {len=20}

k= len-16;  {k=4}
for(int i=0;i<len;i++)
{ 	
b[i]=a[i];
}
ob.div(a,k);
for(int i=0;i<len;i++)
a[i]=a[i]^b[i];
System.out.println("Data to be transmitted: ");
for(int i=0;i<len;i++)
{
System.out.print(a[i]+"");
}
System.out.println();
System.out.println("Enter the Reveived Data: ");
for(int i=0;i<len;i++)
{
a[i]=sc.nextInt();
}
ob.div(a, k);
for(int i=0;i<len;i++)
{
if(a[i]!=0)
{
flag=1; break;
}
}
if(flag==1)
System.out.println("error in data");
else
System.out.println("no error");
}
}
