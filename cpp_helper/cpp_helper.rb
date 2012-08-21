
require 'cpp_create_vars'
require 'cpp_create_class'
require 'cpp_subscriber'
require 'cpp_create_imp_func'

$comment

Shoes.app(:height=>400, :width=>600) do
	############################################################
	# Create Class
	@className = para("Class Name:")
	@className.move(10,10)
	
	@classNameEditLine = edit_line(:width=>150)
	@classNameEditLine.move(110, 10)
	
	@createClass = button "Create" do
		classCreator = ClassCreator.new
		classCreator.create(@classNameEditLine.text)
	end
	@createClass.move(270, 10)
	############################################################
	############################################################
	# Create variables
	@varName = para("Variable Name:")
	@varName.move(10,50)
	
	@varNameEditLine = edit_line(:width=>150)
	@varNameEditLine.move(130, 50)
	
	@createVar = button "Create" do
		varCreator = VarsCreator.new
		varCreator.create(@varNameEditLine.text, $comment)
	end
	@createVar.move(290, 50)
	
	@varComment = button "Comment" do
		$comment = ask("Enter comment")
		#alert comment
	end
	@varComment.move(375, 50)
	############################################################
	############################################################
	# Create Subscriber
	@subscriberClassName = para("Subscribed Class Name:")
	@subscriberClassName.move(10,90)
	
	@subscriberNameEditLine = edit_line(:width=>150)
	@subscriberNameEditLine.move(210, 90)
	
	@subscriberClassButton = button "Create" do
		subscriberCreator = CppSubscriber.new
		subscriberCreator.create(@subscriberNameEditLine.text)
	end
	@subscriberClassButton.move(370, 90)
	############################################################
	############################################################
	# Imp Class
	@impClassName = para("Imp -- ")
	@impClassName.move(10,130)
	@impClassNameClass = para("Class:")
	@impClassNameClass.move(50,130)
	@impClassNameClassEL = edit_line(:width=>150)
	@impClassNameClassEL.move(105, 130)	
	@impClassNameFunc = para("Func:")
	@impClassNameFunc.move(260,130)
	@impClassNameFuncEL = edit_line(:width=>150)
	@impClassNameFuncEL.move(310, 130)		
	@impClassButton = button "Create" do
		impCreator = ImpFuncCreator.new
		impCreator.set_class_name (@impClassNameClassEL.text)
		impCreator.create(@impClassNameFuncEL.text)
	end
	@impClassButton.move(470, 130)	
	
end
