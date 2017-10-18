from shovel import task

@task
def hello(name):
	'''Prints hello and the provided name'''
	print 'Hello, %s' % name

def not_a_task():
	'''Print I'm not considered a task in shovel'''
	pass
