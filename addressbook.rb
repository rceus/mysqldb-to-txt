require 'mysql'
class Employeeinfo
	def get_details
		print("What is your Employee ID (Numeric): ")
		empid = gets()	
		empid = empid.chomp
		print("What is your First Name: ")
		fname = gets()
		fname =fname.chomp
		print("What is your Last Name: ")
		lname = gets()
		lname = lname.chomp
		print("What is your Date of Birth (YYYY-MM-DD): ")
		dob = gets()
		dob = dob.chomp
		print("Which department are you in: ")
		dept = gets()
		dept = dept.chomp
		#connect
		begin
    		con = Mysql.new 'localhost', 'rishabh', 'chhavi', 'employee'
       		con.query("INSERT INTO data(empid,fname,lname,dob,dept) VALUES('#{empid}','#{fname}','#{lname}','#{dob}','#{dept}')")
		rescue Mysql::Error => e
    		puts e.errno
    		puts e.error
		ensure
    		con.close if con
		end
	end

	def db_to_disp
	#connect 
	begin
    	con = Mysql.new 'localhost', 'rishabh', 'chhavi', 'employee'
    	rs = con.query("SELECT * FROM data")
    	n_rows = rs.num_rows
		out_file = File.new("out.txt", "w+")    	
    	out_file.puts ("There are '#{n_rows}' rows in the result set")
    
    	n_rows.times do
        out_file.puts rs.fetch_row.join("\s")
    	end
 
		rescue Mysql::Error => e
    		puts e.errno
    		puts e.error
    
		ensure
    		con.close if con
		end
		out_file.close
	end
end

employee = Employeeinfo.new
employee.get_details
employee.db_to_disp
