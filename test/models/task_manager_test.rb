require_relative '../test_helper'

class TaskManagerTest < ModelTest
  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"
                       })
    task = TaskManager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def create_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"
                       })
  end

  def test_raw_tasks_returns_array_of_task_hashes
    2.times { create_task }
    raw_tasks = TaskManager.raw_tasks
    assert_equal 2, raw_tasks.count
    assert_equal Hash, raw_tasks[0].class
  end

  def test_can_access_all_tasks
    5.times { create_task }
    tasks = TaskManager.all
    assert_equal 5, tasks.count
    assert_equal 2, tasks[1].id
  end

  def test_find_raw_task_by_id
    create_task
    TaskManager.create({title: "Testing", description: "Description"})
    found_task = TaskManager.raw_task(2)
    assert_equal "Testing", found_task["title"]
  end

  def test_find_task_by_id
    create_task
    TaskManager.create({title: "Testing", description: "Description"})
    found_task = TaskManager.find(2)
    assert_equal "Description", found_task.description
  end

  def test_returns_task_not_found_if_searching_for_non_existent_id
    3.times { create_task }
    task = TaskManager.find(9)
    assert_equal "task not found", task
  end

  def test_can_update_task
    create_task
    update_params = {:title => "Updated Title", :description => "Updated Description"}
    TaskManager.update(1, update_params)
    assert_equal "Updated Description", TaskManager.find(1).description
  end

  def test_can_delete_task
    3.times { create_task }
    assert_equal 3, TaskManager.all.count
    TaskManager.delete(1)
    assert_equal 2, TaskManager.all.count
    assert_equal "task not found", TaskManager.find(1)
  end

  def test_can_delete_all_tasks
    5.times { create_task }
    assert_equal 5, TaskManager.all.count
    TaskManager.delete_all
    assert_equal 0, TaskManager.all.count
  end
end
