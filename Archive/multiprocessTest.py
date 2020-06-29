from multiprocessing import Process

def f(name):
    print('hello', name)

if __name__ == '__main__':
    q=('bob','bob2','bob3')
    p = Process(target=f, args=(q,))
    p.start()
    p.join()
