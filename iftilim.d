// IFTI limits
module iftilim;

struct TempT(U)
{
    struct InnerTempT(T)
    {

    }
}

void foo(U : U*)(TempT!U v)
{

}

void fooNested(U, T)(TempT!(U).InnerTempT!T v)
{

}

void main()
{
    // foo(TempT!(float)()); // error
    foo!(float*)(TempT!float()); // OK
     
    TempT!float.InnerTempT!int v;
    // fooNested(v); // error
}
