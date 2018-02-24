require 'spec_helper'
require File.join(File.dirname(".."), 'main.rb')

#run with command 'rspec spec' while in root folder

describe "Schedule" do 
   context "when testing scheduler, function" do 
      
      it "should return an empty hash after resetting schedule" do 
         resetSchedule()
         $testSchedule = getSchedule()
         correct = {}
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
      end

      it "should include new entry after adding to schedule" do   
         addEngineer($testSchedule, "Brown", 2018, 2, 5);
         correct = {"Brown"=>[2018, 2, 5]}
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
         addEngineer($testSchedule, "Ivy", 2018, 1, 29);
         correct = {"Brown"=>[2018, 2, 5], "Ivy"=>[2018, 1, 29]}
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
         addEngineer($testSchedule, "Smith", 2017, 10, 26);
         correct = {"Brown"=>[2018, 2, 5], "Ivy"=>[2018, 1, 29], "Smith"=>[2017, 10, 26]}
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
      end

      it "should switch the weeks of two preexisting engineers" do
         switchEngineers($testSchedule, "Brown", "Smith");
         correct = {"Smith"=>[2018, 2, 5], "Ivy"=>[2018, 1, 29], "Brown"=>[2017, 10, 26]}
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
         switchEngineers($testSchedule, "Ivy", "Smith");
         correct = {"Ivy"=>[2018, 2, 5], "Smith"=>[2018, 1, 29], "Brown"=>[2017, 10, 26]}
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
      end

      it "remove engineers that are deleted" do
         deleteEngineer($testSchedule, 'Ivy')
         correct = {"Smith"=>[2018, 1, 29], "Brown"=>[2017, 10, 26]}
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
      end

      it "should do nothing when a nonexistent engineer is deleted" do
         deleteEngineer($testSchedule, 'Ivy')
         correct = {"Smith"=>[2018, 1, 29], "Brown"=>[2017, 10, 26]}
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
      end

      it "should commit schedule to yml when saving" do
         correct = $testSchedule
         saveSchedule($testSchedule)
         $testSchedule = getSchedule()
         $testSchedule.each do |k, v|
            expect(v).to eq(correct[k])
         end
      end

   end
end