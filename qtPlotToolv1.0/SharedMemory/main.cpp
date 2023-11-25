#include<iostream>
#include<share_memory.h>
#include <time.h>

using namespace std;

string getTime()
{
    time_t timep;
    time (&timep);
    char tmp[64];
    strftime(tmp, sizeof(tmp), "%Y-%m-%d %H:%M:%S",localtime(&timep));
    return tmp;
}

int main()
{
    CShareMemory csm("txh", 128);

    while(1)
    {
        string time = getTime();
        string strs = time.substr(17,20);
        double y = atof(strs.c_str());
        csm.Data2Memory(y);
//        cout << "mychar: "<<mychar<<endl;
        usleep(10);
    }

    return 0;
}
