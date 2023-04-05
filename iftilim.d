// IFTI limits
module iftilim;

struct TempT(U)
{

}

void foo(U : U*)(TempT!U v)
{

}

void main()
{
    // foo(TempT!(float)()); // error
    foo!(float*)(TempT!float()); // OK
}
