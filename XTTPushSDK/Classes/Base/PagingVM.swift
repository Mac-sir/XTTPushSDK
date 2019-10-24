//
//  BasePagingVM.swift
//  FaceChatSwift
//
//  Created by Waynn on 2018/11/23.
//  Copyright © 2018 sa sa. All rights reserved.
//
import MJRefresh
open class PagingVM {

    public var pageOffset: Int = 0

    /// 用于mj_footer状态调整
    public weak var scrollView: UIScrollView?

    @objc
    open func loadNewData(_ ret: @escaping (() -> Void)) {
        print("loadNewData，重载此方法")
    }

    @objc
    open func loadMoreData(_ ret: @escaping (() -> Void)) {
        print("loadMoreData，重载此方法")
    }

    /// 下拉加载好新数据后，调用此方法（根据总数处理）
    ///
    /// - Parameters:
    ///   - curTotalNum: 当前对象数量
    ///   - totalNum: 总数量
    public func didLoadNewPagingData(curTotalNum: Int, totalNum: Int) {
        scrollView?.mj_header.endRefreshing()
        if curTotalNum >= totalNum {
            self.didLoadAllPagingData(true)
        } else {
            self.didLoadNewPagingData()
        }
    }

    /// 上拉加载更多数据后，调用此方法
    ///
    /// - Parameters:
    ///   - curTotalNum: 当前对象数量
    ///   - totalNum: 总数量
    public func didLoadMorePagingData(curTotalNum: Int, totalNum: Int) {

        self.didLoadAllPagingData(curTotalNum >= totalNum)
    }

    /* =========================================== */

    /// 下拉加载好新数据后，调用此方法（根据页数处理）
    ///
    /// - Parameters:
    ///   - currentPage: 当前页数
    ///   - totalPage: 总页数
    public func didLoadNewPagingData(pageOffset: Int, totalPage: Int) {
        self.pageOffset = pageOffset

        scrollView?.mj_header?.endRefreshing()
        if pageOffset + 1 >= totalPage {
            self.didLoadAllPagingData(true)
        } else {
            self.didLoadNewPagingData()
        }
    }

    /// 上拉加载更多数据后，调用此方法 （根据页数处理）
    ///
    /// - Parameters:
    ///   - currentPage: 当前页数
    ///   - totalPage: 总页数
    public func didLoadMorePagingData(pageOffset: Int, totalPage: Int) {
        self.pageOffset = pageOffset

        self.didLoadAllPagingData(pageOffset >= totalPage)
    }
    /* =========================================== */
    
    private func didLoadNewPagingData() {
        scrollView?.mj_footer.resetNoMoreData()
    }

    private func didLoadAllPagingData(_ isTrue: Bool) {
        if isTrue {
            scrollView?.mj_footer.endRefreshingWithNoMoreData()
        } else {
            scrollView?.mj_footer.endRefreshing()
        }
    }
}
