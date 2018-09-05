//
//  TodoViewController.swift
//  Todo List
//
//  Created by Dat Nguyen on 9/5/18.
//  Copyright © 2018 Dat Nguyen. All rights reserved.
//

import UIKit
import ESPullToRefresh

class TodoViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    private var listData: Array<ItemTodo>!
    private var presenter: TodoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listData = []
        configTableView()
        initPresenter()
        loadListTodo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleActionAddMore(_ sender: Any) {
        showDialogCreateTodo()
    }
    
    private func showDialogCreateTodo() {
        let view = CreateTodoView.show(blockSave: { [unowned self] (itemTodo) in
            self.createTodo(data: itemTodo)
        }) { [unowned self] (message) in
            self.showToast(message: message)
        }
    }
    
    private func createTodo(data: ItemTodo) {
        self.showWaitingDialog()
        presenter.createTodo(data: data)
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.es.addPullToRefresh { [unowned self] in
            self.loadListTodo()
        }
    }
    
    private func initPresenter() {
        presenter = TodoPresenter(view: self)
    }
    
    private func loadListTodo() {
        showWaitingDialog()
        presenter.loadListTodo()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TodoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as! TodoTableViewCell
        let data = listData[indexPath.row]
        cell.updateContent(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension TodoViewController: TodoView {
    
    func didLoadListTodoSuccess(listItem: Array<ItemTodo>) {
        self.hideWaitingDialog()
        tableView.es.stopPullToRefresh()
        self.listData = listItem
        tableView.reloadData()
    }
    
    func didLoadListTodoFailure(errorCode: Int, errorMessage: String) {
        self.hideWaitingDialog()
        tableView.es.stopPullToRefresh()
        self.showToast(errorCode: errorCode, errorMessage: errorMessage)
    }
    
    func didCreateTodoSuccess(data: ItemTodo) {
        self.hideWaitingDialog()
        tableView.es.stopPullToRefresh()
        self.listData.append(data)
        tableView.reloadData()
    }
    
    func didCreateTodoFailure(errorCode: Int, errorMessage: String) {
        self.hideWaitingDialog()
        tableView.es.stopPullToRefresh()
        self.showToast(errorCode: errorCode, errorMessage: errorMessage)
    }
    
}
